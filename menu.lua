require "class"
require "menucursor"
require "point"

Menu = {}
Menu.__index=Menu



function  Menu.new(res,size,machine)
	local hud = {
			_name="Menu",
			_resolution={res[1],res[2]},
			_size={size[1],size[2]},
			_items={},
			_nitems=0,
			_selected=1,
			_step=30,
			_machine=machine
		}
	setmetatable(hud,Menu)
	hud._unit=0.01*res[2]/size[2]
	hud._fontSize=30*hud._unit
	hud._font = love.graphics.newFont(hud._fontSize) -- the number denotes the font size
	hud._cursor={}
	return hud
end

setmetatable(Menu,{__index = Class})

function Menu:addItem( item )
	if (self._nitems==0) then
		local text = item:text()
		local x=self._resolution[1]/2-self._font:getWidth(text)/2-10
		self._cursor=MenuCursor.new(Point.new(x,0),self._font:getWidth(text)+20,20+self._fontSize)
	end

	self._nitems=self._nitems+1
	self._items[self._nitems]=item

	local	dh=self._resolution[2]/2-(self._nitems*(self._step*2*self._unit+self._fontSize))/2
	local y=self._step*self._unit+dh-5
	self._cursor:setY(y)
end

function Menu:draw(  )

	if not (self._machine:currentState():next()==nil) then
		self._machine:currentState():next():scene():draw()
		love.graphics.setColor(0,0,0,200)
		love.graphics.rectangle("fill",0,0,self._resolution[1],self._resolution[2])
	end

		self._cursor:draw()
	
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(self._font)

	local	dh=self._resolution[2]/2-(self._nitems*(self._step*2*self._unit+self._fontSize))/2
	local y=self._step*self._unit+dh
	local x=0

	for i=1, self._nitems do 
		x=self._resolution[1]/2-self._font:getWidth(self._items[i]:text())/2
		love.graphics.print(self._items[i]:text(),x,y)
		y=y+self._step*self._unit+self._fontSize
	end	
end

function Menu:selected()
	return self._selected
end

function Menu:update( dt )
	-- body
end

function Menu:keyPressed(key)

	if (key=="return") then
		self._items[self._selected]:signal()
	elseif (key=="escape") then
    	love.event.push("quit")   -- actually causes the app to quit
	elseif key=="up" then
		if (self._selected>1) then
			self._selected=self._selected-1
			self:select(self._selected)
		end
	elseif key=="down" then
		if (self._selected< self._nitems) then
			self._selected=self._selected+1
			self:select(self._selected)
		end
	end



end

function Menu:next()
	self._machine:forward()
end

function Menu:select( ind )
		local text = self._items[ind]:text()
		local x=self._resolution[1]/2-self._font:getWidth(text)/2-10
		local dh=self._resolution[2]/2-(self._nitems*(self._step*2*self._unit+self._fontSize))/2
		local y=ind*self._step*self._unit+(ind-1)*self._fontSize+dh-5
		self._cursor=MenuCursor.new(Point.new(x,y),self._font:getWidth(text)+20,20+self._fontSize)
end