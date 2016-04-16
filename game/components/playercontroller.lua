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
		self.jumpstrength = 5
		self.dashstrength = 5
		self.gravity = 0.2
		self.movementLocked = false
		self.world = world

		self.animationSet = self.entity:getComponent("AnimationSet")

		self.state = "falling"

		self.orientation = Vector(1, 0)
		self.wallgrabOrientation = Vector(0, 0)

		self.hitbox = Hitbox(self.entity, world, 16, 16, 0, 0)
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
		if self.state == "wallgrab" and desiredMovement.x ~= 0 then
			if desiredMovement.x ~= self.wallgrabOrientation then
				self.state = "falling"
			end
		end

		if desiredMovement.x ~= 0 then
			self.orientation.x = desiredMovement.x
		end

		self.velocity.x = self.velocity.x + desiredMovement.x * self.speed
		if self.velocity.x > self.maxspeed then
			self.velocity.x = self.maxspeed
		elseif self.velocity.x < -self.maxspeed then
			self.velocity.x = -self.maxspeed
		end

		if desiredMovement.x == 0 then
			if self.velocity.x > 0 then
				self.velocity.x = math.max(self.velocity.x - self.decel, 0)
			else
				self.velocity.x = math.min(self.velocity.x + self.decel, 0)
			end
		end
	end

	if self.state == "jumping" and self.velocity.y > 0 then
		self.state = "falling"
	end

	self:setAnimation()
	self.animationSet:setFlip(self.orientation.x ~= 1)

	self.velocity.y = self.velocity.y + self.gravity

	self:move(self.velocity)
end

function PlayerController:setAnimation()
	local animationSet = self.animationSet

	if self.state == "jumping" or self.state == "falling" then
		animationSet:switchAnimation("Jump")
	elseif self.state == "dashing" then
		animationSet:switchAnimation("Dash")
	else
		if math.abs(self.velocity.x) > 0 then
			animationSet:switchAnimation("Walk")
		else 
			animationSet:switchAnimation("Idle")
		end
	end
end

function PlayerController:jump()
	if self.state == "walking" then
		self.velocity.y = self.jumpstrength * -1
		self.state = "jumping"
	end

	if self.state == "wallgrab" then
		self.state = "jumping"
		self.velocity.y = self.jumpstrength * -1
		self.velocity.x = self.wallgrabOrientation.x * 1
		self.movementLocked = true
		self.timer.after(10, function()
			self.movementLocked = false
		end)
	end
end

function PlayerController:land()
	if self.state ~= "dashing" then
		self.state = "walking"
	end
	self.velocity.y = 0
end

function PlayerController:startWallGrab(normal_x)
	if self.state == "falling" then
		self.state = "wallgrab"
		self.velocity.y = 0
		self.wallgrabOrientation.x = normal_x
	end
end

function PlayerController:dash()
	local afterImageComponent = self.entity:getComponent("AfterImage")

	if not self.movementLocked then
		self.state = "dashing"
		self.movementLocked = true
		self.velocity.y = 0 -- math.max(self.velocity.y, 0)
		-- afterImageComponent:show()
		self.velocity.x = self.orientation.x * self.dashstrength
		self.timer:clear()
		self.timer.tween(22, self.velocity, {x = self.velocity.x * 0.75}, "linear")
		self.timer.after(24, function()
			self.state = "walking"
			self.movementLocked = false
		end)
		self.timer.after(30, function()
			-- afterImageComponent:hide()
		end)
	end
end

function PlayerController:onCollide(collision)
	if collision.normal.y == -1 then
		self:land()
	elseif collision.normal.y == 1 then
		self.state = "falling"
		self.velocity.y = 0
	end

	if collision.normal.x ~= 0 and collision.normal.y == 0 then
		self:startWallGrab(collision.normal.x)
	end
end

function PlayerController:drawAfter()
	-- self.hitbox:draw()

	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(fonts.main)
	love.graphics.printf(self.state, math.floor(self.entity.position.x - 40), math.floor(self.entity.position.y - 30), 80, "center")
end

function PlayerController:onAction(action)
	if action == "cancel" then
		self:jump()
	elseif action == "special" then
		self:dash()
	end
end

return PlayerController