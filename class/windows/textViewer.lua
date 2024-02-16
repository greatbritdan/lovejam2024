WindowTextViewer = Class("WindowTextViewer", Window)

function WindowTextViewer:initialize(desktop, x, y, w, h, content, filename)
    Window.initialize(self, desktop, x, y, w, h, "text viewer")
    self.content = content or "error: no content provided, please open a valid text file."
    self.filename = filename or "unknown.text"

    self.program = "textviewer"
    self.icon = "textviewer"
end

function WindowTextViewer:draw()
    if self.minimized then return end

    -- Draw window
    Window.draw(self)
    love.graphics.setColor(self:getColor("subbackground"))
    love.graphics.rectangle("fill", self.x, self.y+self.navbar.h, self.w, 13)

    -- Print out content
    love.graphics.setColor({0.5,0.5,0.5})
    love.graphics.printf(self.filename, self.x+4, self.y+self.navbar.h+3, self.w-8, "left")
    love.graphics.setColor({1,1,1})
    love.graphics.printf(self.content, self.x+4, self.y+self.navbar.h+17, self.w-8, "left")

    -- Draw UI
    Window.drawUI(self)
end