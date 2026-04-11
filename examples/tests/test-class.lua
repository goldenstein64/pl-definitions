local class = require("pl.class") ---@type pl.ClassModule
local test = require("pl.test")
asserteq = test.asserteq
T = test.tuple

---@class AClass : ABase, pl.Class
---@overload fun(): A
A = class() --[[@as AClass]]

---@class ABase
local ABase = A --[[@as ABase]]

---@class A : ABase, pl.Instance
---@field a number

---@param self A
function ABase:_init()
	self.a = 1
end

-- calling base class' ctor automatically
---@class A1Class : A1Base, AClass
---@overload fun(): A1
A1 = class(A) --[[@as A1Class]]

---@class A1Base : ABase
local A1Base = A1 --[[@as A1Base]]

---@class A1 : A1Base, A

asserteq(A1(), { a = 1 })

-- explicitly calling base ctor with super

---@class BClass : BBase, AClass
---@overload fun(): B
B = class(A) --[[@as BClass]]

---@class BBase : ABase
local BBase = B --[[@as BBase]]

---@class B : BBase, A
---@field b number
---@field eee number?
---@field g number?

---@param self B
function BBase:_init()
	self:super()
	self.b = 2
end

---@param self B
function BBase:foo()
	self.eee = 1
end

---@param self B
function BBase:foo2()
	self.g = 8
end

asserteq(B(), { a = 1, b = 2 })

-- can continue this chain

---@class CClass : CBase, BClass
---@overload fun(): C
C = class(B) --[[@as CClass]]

---@class CBase : BBase
local CBase = C --[[@as CBase]]

---@class C : CBase, B
---@field c number

---@param self C
function CBase:_init()
	self:super()
	self.c = 3
end

---@param self C
function CBase:foo()
	-- recommended way to call inherited version of method...
	B.foo(self)
end

c = C()
c:foo()

asserteq(c, { a = 1, b = 2, c = 3, eee = 1 })

-- test indirect inherit

---@class DClass : DBase, CClass
---@overload fun(): D
D = class(C) --[[@as DClass]]

---@class DBase : CBase
local DBase = D --[[@as DBase]]

---@class D : DBase, C

---@class EClass : EBase, DClass
---@overload fun(): E
E = class(D) --[[@as EClass]]

---@class EBase : DBase
---@field e number
---@field eeee number?
local EBase = E --[[@as EBase]]

---@class E : EBase, D

---@param self E
function EBase:_init()
	self:super()
	self.e = 4
end

---@param self E
function EBase:foo()
	-- recommended way to call inherited version of method...
	self.eeee = 5
	C.foo(self)
end

---@class FClass : FBase, EClass
---@overload fun(): F
F = class(E) --[[@as FClass]]

---@class FBase : EBase
local FBase = F --[[@as FBase]]

---@class F : FBase, E
---@field f number

---@param self F
function F:_init()
	self:super()
	self.f = 6
end

f = F()
f:foo()
f:foo2() -- Test : invocation inherits this function from all the way up in B

asserteq(f, { a = 1, b = 2, c = 3, eee = 1, e = 4, eeee = 5, f = 6, g = 8 })

-- Test that inappropriate calls to super() fail gracefully

---@class GClass : GBase, pl.Class
---@overload fun(): G
G = class() --[[@as GClass]] -- Class with no init

---@class GBase
local GBase = G --[[@as GBase]]

---@class G : GBase, pl.Instance

---@class HClass : HBase, GClass
---@overload fun(): H
H = class(G) --[[@as HClass]] -- Class with an init that wrongly calls super()

---@class HBase : GBase
local HBase = H --[[@as HBase]]

---@class H : HBase, G

---@param self H
function H:_init()
	self:super() -- Notice: G has no _init
end

---@class IClass : IBase, HClass
---@overload fun(): I
I = class(H) --[[@as IClass]] -- Inherits the init with a bad super

---@class IBase : HBase

---@class I : IBase, H

---@class JClass : JBase, IClass
---@overload fun(): J
J = class(I) --[[@as JClass]] -- Grandparent-inits the init with a bad super

---@class JBase : IBase

---@class J : JBase, I

---@class KClass : KBase, JClass
---@overload fun(): K
K = class(J) --[[@as KClass]] -- Has an init, which calls the init with a bad super

---@class KBase : JBase
local KBase = K --[[@as KBase]]

---@class K : KBase, J

---@param self K
function K:_init()
	self:super()
end

local function createG()
	return G()
end

local function createH() -- Wrapper function for pcall
	return H()
end

local function createJ()
	return J()
end

local function createK()
	return K()
end

assert(pcall(createG)) -- Should succeed
assert(not pcall(createH)) -- These three should fail
assert(not pcall(createJ))
assert(not pcall(createK))

--- class methods!
assert(c:is_a(C)) -- no idea why these are warnings, they inherit from pl.Class
assert(c:is_a(B)) -- making these directly inherit from pl.Class doesn't work
assert(c:is_a(A))
assert(c:is_a() == C)
assert(C:class_of(c))
assert(B:class_of(c))
assert(A:class_of(c))

--- metamethods!

function C:__tostring()
	return ("%d:%d:%d"):format(self.a, self.b, self.c)
end

function C.__eq(c1, c2)
	return c1.a == c2.a and c1.b == c2.b and c1.c == c2.c
end

asserteq(C(), { a = 1, b = 2, c = 3 })

asserteq(tostring(C()), "1:2:3")

asserteq(C() == C(), true)

----- properties -----

---@class MyPropsClass : MyPropsBase, pl.Class
local MyProps = class(class.properties)

---@class MyPropsBase
local MyPropsBase = MyProps --[[@as MyPropsBase]]

---@class MyProps : MyPropsBase, pl.Instance
---@field a number
---@field b number
---@field _a number
---@field _b number

local setted_a, got_b

---@param self MyProps
function MyPropsBase:_init()
	self._a = 1
	self._b = 2
end

function MyPropsBase:set_a(v)
	setted_a = true
	self._a = v
end

function MyPropsBase:get_b()
	got_b = true
	return self._b
end

function MyPropsBase:set(a, b)
	self._a = a
	self._b = b
end

local mp = MyProps()

mp.a = 10

asserteq(mp.a, 10)
asserteq(mp.b, 2)
asserteq(setted_a and got_b, true)

---@class MorePropsClass : MorePropsBase, MyPropsClass
---@overload fun(): MoreProps
MoreProps = class(MyProps) --[[@as MorePropsClass]]

---@class MorePropsBase
local MorePropsBase = MoreProps --[[@as MorePropsBase]]

---@class MoreProps : MorePropsBase, MyProps
---@field c number
---@field _c number

local setted_c

---@param self MoreProps
function MorePropsBase:_init()
	self:super()
	self._c = 3
end

---@param self MoreProps
---@param c number
function MorePropsBase:set_c(c)
	setted_c = true
	self._c = c
end

mm = MoreProps()

mm:set(10, 20)
mm.c = 30

asserteq(setted_c, true)
asserteq(T(mm.a, mm.b, mm.c), T(10, 20, 30))
