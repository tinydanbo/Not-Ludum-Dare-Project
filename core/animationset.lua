Class = require "lib.hump.class"
json = require "lib.json.json"

AnimationSet = Class{
	init = function(self, directory, filename)
		local file_contents = love.filesystem.read(directory .. "/" .. filename)
		local file_decoded = json.decode(file_contents)

		self.flip_x = false

		self:loadAnimations(file_decoded)
		self:loadImageFiles(file_decoded, directory)

		local first_animation_name = nil
		for k,v in pairs(self.animations) do
			if first_animation_name == nil then
				first_animation_name = k
			end
		end
		self.currentAnimationName = first_animation_name
	end
}

function AnimationSet:switchAnimation(name, reset)
	self.currentAnimationName = name

	if reset then
		local currentAnimation = self.animations[self.currentAnimationName]
		currentAnimation.time = 0
	end
end

function AnimationSet:update()
	local currentAnimation = self.animations[self.currentAnimationName]

	currentAnimation.time = currentAnimation.time + math.floor(1000/60)

	if currentAnimation.time > currentAnimation.length then
		currentAnimation.time = currentAnimation.time - currentAnimation.length
	end
end

function AnimationSet:getFrame()
	local currentAnimation = self.animations[self.currentAnimationName]

	local best_frame = 1
	for _,keyframe in ipairs(currentAnimation.mainline_keyframes) do
		if keyframe.time < currentAnimation.time then
			best_frame = _
		end
	end

	return best_frame
end

function AnimationSet:draw(x, y)
	local currentAnimation = self.animations[self.currentAnimationName]

	local currentMainlineKeyframe = currentAnimation.mainline_keyframes[self:getFrame()]

	for _,object in ipairs(currentMainlineKeyframe.object_ref) do
		local timeline = tonumber(object.timeline)
		local key = tonumber(object.key)

		local timeline_keyframe = currentAnimation.timelines[timeline][key]
		local folder_id = tonumber(timeline_keyframe.object.folder)
		local file_id = tonumber(timeline_keyframe.object.file)
		local timeline_keyframe_x = timeline_keyframe.object.x or 0
		local timeline_keyframe_y = timeline_keyframe.object.y or 0
		local timeline_keyframe_scalex = timeline_keyframe.object.scale_x or 1
		local timeline_keyframe_scaley = timeline_keyframe.object.scale_y or 1

		local image_file = self.folders[folder_id].files[file_id]

		if self.flip_x then
			timeline_keyframe_x = timeline_keyframe_x * -1
			timeline_keyframe_scalex = timeline_keyframe_scalex * -1
		end

		love.graphics.draw(
			image_file.image, 
			math.floor(x + timeline_keyframe_x), 
			math.floor(y - timeline_keyframe_y), 
			0, 
			timeline_keyframe_scalex, 
			timeline_keyframe_scaley, 
			math.floor(image_file.pivot_x), 
			math.floor(image_file.pivot_y)
		)
	end
end

function AnimationSet:loadAnimations(spriter_data)
	self.animations = {}

	local animation_data = spriter_data.entity[1].animation

	for _,animation in ipairs(animation_data) do
		local new_animation = {}
		new_animation = {
			time = 0,
			length = animation.length
		}

		new_animation.mainline_keyframes = {}

		for _,frame in ipairs(animation.mainline.key) do
			local new_mainline_keyframe = {
				time = frame.time or 0
			}
			new_mainline_keyframe.object_ref = frame.object_ref
			table.insert(new_animation.mainline_keyframes, new_mainline_keyframe)
		end

		new_animation.timelines = {}

		for _,timeline in ipairs(animation.timeline) do
			local new_timeline = {}

			for _,timeline_frame in ipairs(timeline.key) do
				new_timeline[timeline_frame.id] = {
					object = timeline_frame.object,
					spin = timeline_frame.spin
				}
			end

			new_animation.timelines[timeline.id] = new_timeline
		end

		self.animations[animation.name] = new_animation
	end
end

function AnimationSet:setFlip(flip)
	self.flip_x = flip
end

function AnimationSet:loadImageFiles(spriter_data, root)
	self.folders = {}

	for _,folder in ipairs(spriter_data.folder) do
		local new_folder = {}
		new_folder.files = {}

		for _,file in ipairs(folder.file) do
			new_folder.files[file.id] = {
				height = file.height,
				width = file.width,
				pivot_x = file.pivot_x * file.width,
				pivot_y = (1 - file.pivot_y) * file.height,
				image = love.graphics.newImage(root .. "/" .. file.name)
			}
		end

		self.folders[folder.id] = new_folder
	end
end

return AnimationSet