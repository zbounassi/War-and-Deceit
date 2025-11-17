--[[

    First Video

-- Class Def (needs a metatable)
local Class = {
    a = 0, 
    b = 0,
    c = 0
}

-- Set up a table 
-- Has an empty table and the name of the Class
-- Sets a local self to the metatable (no inheritance here)
function Class.new(a, b, c)
    local self = setmetatable({}, Class)

    self.a = a
    self.b = b
    self.c = c 

    return self -- returns a usable variable here
end

-- Colon means that it is a metamethod (automatically passes self in)
function Class:add()
    return self.a + self.b + self.c
end

-- Allows the use of the self value
function Class.__index(tab, key)
    return Class[key]
end

local Class2 = Class

Class2.d = 7

function Class2.new(a, b, c, d)
    local self = setmetatable({}, Class2)

    self.a = a
    self.b = b
    self.c = c
    self.d = d

    return self    
end

function Class2:add()
    return self.a + self.b + self.c + self.d
end


function Class2:sub()
    return self.a - self.b - self.c - self.d
end


-- Prints just the c value of Instance
local Instance = Class2.new(1,3,5,6)
print(Instance:add())
print(Instance:sub())

]]--

--[[
        Second Video
]]--

-- A table is a simple data type that stores any values of any type

-- A metatable is a table attached to another table that acts as a 'helper' table, defining what should happen
-- when specific situations occur

-- myTable = myTable + 3 will not do anything as lua cannot determine what you mean to do (without further definitions)

-- Metamethod: a value (usually functions) attached to reserved keys in a metatable used during specific situations

local myTable = {1, 2, 3} 

local myMetatable = {
    __add = function(ourTable, value)
        for i, v in ipairs(ourTable) do
            ourTable[i] = v + value
        end
        return ourTable
    end,
}

setmetatable(myTable, myMetatable)

myTable = myTable + 3

for i, v in ipairs(myTable) do
    print("The value of " .. i .. " is " .. myTable[i])
end
