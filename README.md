# FramerateManager

Simple module that provides a flexible and efficient way to create heartbeat task that executes at capped frames-per-second (FPS) rate. Made for non-visual optimizations for you games.

[**Roblox Marketplace Asset**](https://create.roblox.com/store/asset/88912190810548/FramerateManager)

# Functions

```lua
type funcSettings = {
	FrameRate:number?,
	Paused:boolean?,
}
```

```Lua
function FramerateManager.CreateHBJob(job:(deltaTime:number)->(),Fsettings:funcSettings)
```
*Creates new job with optinal settings*


```Lua
function FramerateManager:Update(delta)
```
*Runs binded job*


```Lua
function FramerateManager:SetPaused(bool:boolean)
```
*Set paused state*


```Lua
function FramerateManager:Remove()
```
*Removes function from manager*
