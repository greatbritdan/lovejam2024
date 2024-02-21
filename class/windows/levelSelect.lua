WindowLevelSelect = Class("WindowLevelSelect", Window)

function WindowLevelSelect:initialize(desktop, x, y, w, h)
    Window.initialize(self, desktop, x, y, 300, 200, "level select", 300, 200)
    self.program = "levelselect"
    self.icon = "levelselect"

    self.level = DesktopName
    self.config = love.filesystem.load("desktops/"..self.level.."/config.lua")()

    self.elements = {}
    self.elements.next = UI.button({x=self.w-18, y=2, w=16, h=self.h-self.navbar.h-4, text=">", desktop=desktop, resize=function()
        self.elements.next.h = self.h-self.navbar.h-4
    end, func=function()
        local idx = TableContains(Desktops, self.level)
        if idx then
            if idx == #Desktops then
                self.level = Desktops[1]
            else
                self.level = Desktops[idx+1]
            end
            self.config = love.filesystem.load("desktops/"..self.level.."/config.lua")()
        end
    end})
    self.elements.prev = UI.button({x=2, y=2, w=16, h=self.h-self.navbar.h-4, text="<", desktop=desktop, resize=function()
        self.elements.next.h = self.h-self.navbar.h-4
    end, func=function()
        local idx = TableContains(Desktops, self.level)
        if idx then
            if idx == 1 then
                self.level = Desktops[#Desktops]
            else
                self.level = Desktops[idx-1]
            end
            self.config = love.filesystem.load("desktops/"..self.level.."/config.lua")()
        end
    end})
    self.elements.play = UI.button({x=22, y=self.h-34, w=self.w-44, h=16, text="play", desktop=desktop, resize=function()
        self.elements.play.y = self.y+self.h-34
        self.elements.play.w = self.w-44
    end, func=function()
        WindowInboxData = {}
        WindowBankData = {}
        WindowAntivirusData = {}
    
        local idx = TableContains(Desktops, self.level)
        DesktopName = Desktops[idx]
        Screen:changeState("desktop", {"fade", 0.25, {0,0,0}}, {"fade", 0.25, {0,0,0}})
    end})
    self:sync()
end

function WindowLevelSelect:draw()
    if self.minimized then return end

    -- Draw window
    Window.draw(self)

    love.graphics.setColor({1,1,1})
    local smallestScale = (self.w-40)/self.config.background.img:getWidth()
    local x, y = self.x+(self.w-self.config.background.img:getWidth()*smallestScale)/2, self.y+self.navbar.h+(self.h-self.navbar.h-self.config.background.img:getHeight()*smallestScale)/2
    love.graphics.draw(self.config.background.img, x, y, 0, smallestScale, smallestScale)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.config.pfp, x+4, y+4)
    love.graphics.print(self.config.name, x+44, y+16)

    -- Draw UI
    Window.drawUI(self)
end