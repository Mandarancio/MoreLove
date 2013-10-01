require "class"

Array = {}
Array.__index=Array

function  Array.new()
	local array = {
			_x=x,
			_y=y,
			_list={},
			_size=0
		}
	setmetatable(array,Array)
	return array
end

setmetatable(Array,{__index = Class})

function Array:add(item)
	self._list[self._size]=item
	self._size=self._size+1
end

function Array:get(ind)
	if (ind<self._size) then
		return self._list[ind]
	else
		return nil
	end
end

function Array:addAt(ind,item)
	if (ind<self._size) then
		self._list[ind]=item
	else
		self:add(item)
	end
end

function Array:contains( item )
	for i=0,size-1 do
		if self._list[i]==item then
			return true
		end
	end	
	return false
end

function Array:indexOf( item )
	for i=0,self._size-1 do
		if self._list[i]==item then
			return i
		end
	end	
	return -1
end

function Array:remove( item)
	self:removeAt(self:indexOf(item))
end

function Array:removeAt( ind )
	if ind>=0 and ind<self._size then 
		local array ={}
			for i=0,ind-1 do
			array[i]=self._list[i]
		end
		for i=ind+1,self._size-1 do
			array[i-1]=self._list[i]
		end
		self._size=self._size-1	
		
		self._list=array

	end
end

function Array:print( )	
	print("Array["..self._size.."]")
	for i=0,self._size-1 do 
		print(i..":"..self._list[i])
	end
end

function Array:size(  )
	return self._size
end