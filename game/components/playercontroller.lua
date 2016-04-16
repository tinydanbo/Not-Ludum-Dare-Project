Class = require "lib.hump.class"
Timer = require "lib.hump.timer"
Vector = require "lib.hump.vector"
Hitbox = require "core.hitbox"

PlayerController = Class{
	init = function(self, entity, world)
		self.entity = entity
		self.timer = Timer.new()
		self.velocity = Vector(0, 0)

		self.speed = 0.9
		self.maxspeed = 3
		self.decel = 0.9
		self.jumpstrength = 4
		self.gravity = 0.2

		self.dashlength = 30
		self.wallgrabframes = 0


		self.movementLocked = false
		self.world = world

		self.animationView = self.entity:getComponent("AnimationView")

		self.state = "falling"

		self.orientation = Vector(1, 0)
		self.wallgrabOrientation = Vector(0, 0)

		self.hitbox = Hitbox(self.entity, world, 12, 20, 0, 0)
	end
}

function PlayerController:move(movement)
	local actual_x, actual_y = self.hitbox:move(movement)
	self.entity.position.x = actual_x
	self.entity.position.y = actual_y
end

function PlayerController:getDesiredMovement()
	local desiredMovement = Vector(0, 0)

	if love.keyboard.isDown(unpack(bindings.left)) then
		desiredMovement.x = -1
	elseif love.keyboard.isDown(unpack(bindings.right)) then
		desiredMovement.x = 1
	end

	return desiredMovement
end

function PlayerController:update()
	self.timer.update(1)
	local desiredMovement = self:getDesiredMovement()

	if not self.movementLocked then

		if desiredMovement.x ~= 0 then
			self.orientation.x = desiredMovement.x
		end

		if self.state == "wallgrab" then
			if desiredMovement.x == self.wallgrabOrientation.x then
				self.state = "falling"
				self.animationView:switchAnimation("Jump", true)
			else
				self.wallgrabframes = self.wallgrabframes - 1
				if self.wallgrabframes <= 0 then
					self.state = "falling"
					self.animationView:switchAnimation("Jump", true)
					self.orientation.x = self.orientation.x * -1
				end
			end
		end

		local decel = self.decel
		local speed = self.speed
		local maxspeed = self.maxspeed

		if self.state == "dashing" or self.state == "dashjumping" then
			maxspeed = maxspeed * 2
			speed = speed * 3
			decel = decel * 0.5
		end

		self.velocity.x = self.velocity.x + desiredMovement.x * speed
		if self.velocity.x > maxspeed then
			self.velocity.x = maxspeed
		elseif self.velocity.x < -maxspeed then
			self.velocity.x = -maxspeed
		end

		if desiredMovement.x ~= 0 and self.animationView:getAnimationName() == "Idle" then
			self.animationView:switchAnimation("Walk", true)
		elseif desiredMovement.x == 0 and self.animationView:getAnimationName() == "Walk" then
			self.animationView:switchAnimation("Idle", true)
		end

		if desiredMovement.x == 0 then
			if self.velocity.x > 0 then
				self.velocity.x = math.max(self.velocity.x - decel, 0)
			else
				self.velocity.x = math.min(self.velocity.x + decel, 0)
			end
		end
	end

	if (self.state == "jumping" or self.state == "dashjumping") and self.velocity.y > 0 then
		self.state = "falling"
	end

	if (self.state == "walking") and self.velocity.y > 0.5 then
		self.state = "falling"
		self.animationView:switchAnimation("Jump", true)
	end

	self:setAnimation()

	if self.state == "wallgrab" then
		self.velocity.y = self.gravity
	else
		self.velocity.y = self.velocity.y + self.gravity
	end

	self:move(self.velocity)
end

function PlayerController:receiveEvent(event, animationName)
	if event == "animation loop" then
		if animationName == "Land" then
			self.animationView:switchAnimation("Idle", true)
		elseif animationName == "ClimbCling" then
			self.animationView:switchAnimation("Climb", true)
		end
	end
end

function PlayerController:setAnimation()
	local animationView = self.entity:getComponent("AnimationView")

	local shouldFlip = self.orientation.x ~= 1

	animationView:setOffset(0, 10)

	if animationView:getAnimationName() == "Idle" then
		animationView:setOffset(0, 11)
	end

	if animationView:getAnimationName() == "Climb" or animationView:getAnimationName() == "ClimbCling" then
		shouldFlip = not shouldFlip
		if self.orientation.x > 0 then
			animationView:setOffset(6, 11)
		else
			animationView:setOffset(-6, 11)
		end
	end

	animationView:setFlip(shouldFlip)
end

function PlayerController:jump()
	if self.state == "walking" then
		self.animationView:switchAnimation("Jump", true)
		self.velocity.y = self.jumpstrength * -1
		self.state = "jumping"
	end

	if self.state == "dashing" then
		self.animationView:switchAnimation("Jump", true)
		self.velocity.y = self.jumpstrength * -1
		self.state = "dashjumping"
	end

	if self.state == "wallgrab" then
		self.state = "jumping"
		self.animationView:switchAnimation("Jump", true)
		self.velocity.y = self.jumpstrength * -1
		self.velocity.x = self.wallgrabOrientation.x * 1
	end
end

function PlayerController:land()
	if self.state == "jumping" or self.state == "falling" then
		self.animationView:switchAnimation("Land", true)
		self.state = "walking"
	end
	self.velocity.y = 0
end

function PlayerController:attack()
	self.state = "attacking"
end

function PlayerController:startWallGrab(normal_x)
	if self.state == "falling" or self.state == "jumping" or self.state == "dashjumping" then
		self.wallgrabframes = 20
		self.animationView:switchAnimation("ClimbCling", true)
		self.state = "wallgrab"
		self.velocity.y = 0
		self.wallgrabOrientation.x = normal_x
	end
end

function PlayerController:maintainWallGrab(normal_x)
	self.wallgrabframes = 20
	self.state = "wallgrab"
	self.velocity.y = 0
	self.wallgrabOrientation.x = normal_x
end

function PlayerController:dash()
	if self.state == "dashing" or self.state == "jumping" or self.state == "falling" or self.state == "wallgrab" then return end
	local afterImageComponent = self.entity:getComponent("AfterImage")

	self.state = "dashing"
	self.animationView:switchAnimation("Dash", true)
	self.velocity.y = 0 -- math.max(self.velocity.y, 0)
	afterImageComponent:show()
	self.timer:clear()
	self.timer.after(self.dashlength, function()
		self.state = "walking"
		self.animationView:switchAnimation("Idle", true)
	end)
	self.timer.after(self.dashlength + 8, function()
		afterImageComponent:hide()
	end)
end

function PlayerController:onCollide(collision)
	if collision.normal.y == -1 then
		self:land()
	elseif collision.normal.y == 1 then
		self.velocity.y = 0
	end

	if collision.normal.x ~= 0 and collision.normal.y == 0 then
		if self.state == "wallgrab" then
			self:maintainWallGrab(collision.normal.x)
		else
			self:startWallGrab(collision.normal.x)
		end
	end
end

function PlayerController:drawAfter()
	-- self.hitbox:draw()

	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(fonts.main)
	love.graphics.printf(self.state, math.floor(self.entity.position.x - 40), math.floor(self.entity.position.y - 30), 80, "center")
end

function PlayerController:onAction(action)
	if action == "fire" then
		self:attack()
	elseif action == "cancel" then
		self:jump()
	elseif action == "special" then
		self:dash()
	end
end

return PlayerController