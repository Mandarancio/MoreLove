require "array"

Buffer = {}
Buffer.__index=Buffer

function  Buffer.new(size)
	local array = {
			_x=x,
			_y=y,
			_list={},
			_size=0,
			_dimension=size
		}
	setmetatable(array,Buffer)
	return array
end

setmetatable(Buffer,{__index = Array})

function Buffer:add( item )
	while self._size>=self._dimension do
		self:removeAt(0)
	end
	self._list[self._size]=item
	self._size=self._size+1
end

function Buffer:dimension(  )
	return self._dimension
end