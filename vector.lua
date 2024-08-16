---@meta

-- We follow sections and order from lua_api.txt
-- except for operators: they are in the class definition

---@class vector
vector = {}

-- NOTE: No eq operator
-- https://github.com/LuaLS/lua-language-server/issues/1882

---@class vector.Vector
---
---@field x number
---@field y number
---@field z number
---
---@operator unm : vector.Vector
---@operator add(vector.Vector) : vector.Vector
---@operator sub(vector.Vector) : vector.Vector
---@operator mul(number) : vector.Vector
---@operator div(number) : vector.Vector

-- Common functions and methods
-------------------------------

---@param x number
---@param y? number
---@param z? number
---@return vector.Vector
---@nodiscard
--- * Returns a new vector `(a, b, c)`.
--- * Deprecated: `vector.new()` does the same as `vector.zero()` and
---   `vector.new(v)` does the same as `vector.copy(v)`
function vector.new(x, y, z) end

---@param s string
---@param init? integer # If given starts looking for the vector at this string index
---@return nil | vector.Vector, integer # integer = next position in the string after the vector
---@nodiscard
--- * Returns `v, np`, where `v` is a vector read from the given string `s` and
---   `np` is the next position in the string after the vector.
--- * Returns `nil` on failure.
--- * `s`: Has to begin with a substring of the form `"(x, y, z)"`. Additional
---        spaces, leaving away commas and adding an additional comma to the end
---        is allowed.
--- * `init`: If given starts looking for the vector at this string index.
function vector.from_string(s, init) end

---@param v vector.Vector
---@return string
---@nodiscard
--- * Returns a string of the form `"(x, y, z)"`.
--- *  `tostring(v)` does the same.
function vector.to_string(v) end

---@param p1 vector.Vector
---@param p2 vector.Vector
---@return vector.Vector
---@nodiscard
--- * Returns a vector of length 1 with direction `p1` to `p2`.
--- * If `p1` and `p2` are identical, returns `(0, 0, 0)`.
function vector.direction(p1, p2) end

---@param v vector.Vector
---@param x vector.Vector | number
---@return vector.Vector
---@nodiscard
--- * Returns a vector.
--- * If `x` is a vector: Returns the sum of `v` and `x`.
--- * If `x` is a number: Adds `x` to each component of `v`.
function vector.add(v, x) end

---@param v vector.Vector
---@param x vector.Vector | number
---@return vector.Vector
---@nodiscard
--- * Returns a vector.
--- * If `x` is a vector: Returns the difference of `v` subtracted by `x`.
--- * If `x` is a number: Subtracts `x` from each component of `v`.
function vector.subtract(v, x) end

---@param v vector.Vector
---@param x vector.Vector | number
---@return vector.Vector
---@nodiscard
--- * Returns a vector.
--- * If `x` is a vector: Returns the difference of `v` subtracted by `x`.
--- * If `x` is a number: Subtracts `x` from each component of `v`.
function vector.subtract(v, x) end

---@param v vector.Vector
---@param s number
---@return vector.Vector
---@nodiscard
--- * Returns a scaled vector.
--- * Deprecated: If `s` is a vector: Returns the Schur product.
function vector.multiply(v, s) end

---@param v vector.Vector
---@param s number
---@return vector.Vector
---@nodiscard
--- * Returns a scaled vector.
--- * Deprecated: If `s` is a vector: Returns the Schur quotient.
function vector.divide(v, s) end

-- Rotation-related functions
-----------------------------

---@param v vector.Vector
---@param r vector.Vector
---@return vector.Vector
---@nodiscard
--- * Applies the rotation `r` to `v` and returns the result.
--- * `vector.rotate(vector.new(0, 0, 1), r)` and
---   `vector.rotate(vector.new(0, 1, 0), r)` return vectors pointing
---   forward and up relative to an entity's rotation `r`.
function vector.rotate(v, r) end

---@param v1 vector.Vector
---@param v2 vector.Vector
---@param a number
---@return vector.Vector
---@nodiscard
--- * Returns `v1` rotated around axis `v2` by `a` radians according to
---   the right hand rule.
function vector.rotate_around_axis(v1, v2, a) end

---@param direction vector.Vector
---@param up? vector.Vector
---@return vector.Vector
---@nodiscard
--- * Returns a rotation vector for `direction` pointing forward using `up`
---   as the up vector.
--- * If `up` is omitted, the roll of the returned vector defaults to zero.
--- * Otherwise `direction` and `up` need to be vectors in a 90 degree angle to each other.
function vector.dir_to_rotation(direction, up) end

---@param pos vector.Vector
---@param min vector.Vector
---@param max vector.Vector
---@return boolean
---@nodiscard
function vector.in_area(pos, min, max) end
