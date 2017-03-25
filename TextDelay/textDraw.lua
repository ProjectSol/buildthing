textDraw = {}
delayedText = {}
text = ''
fullText = {}
utf8 = require("utf8")
font = love.graphics.newFont()
mainFont = love.graphics.newFont("assets/good times rg.ttf", 12)
debugFont = love.graphics.newFont("assets/good times rg.ttf", 50)
status = love.graphics.newFont("assets/good times rg.ttf", 12)

function textDraw:delayedNewText(string, subs)
  if fullText[subs] then
    fullText[subs] = ''
  end
  tbl = {}
  table.insert(delayedText, tbl)
  table.insert(fullText, text)
  --table.insert(done, tbl)
  for i = 1,string.len(string) do
    local e = string.sub(string, i, i)
    table.insert(delayedText[subs], e)
  end
  t = love.timer:getTime()
end

function textDraw:delayDraw(subs, speed, x, y, Font)
  q = love.timer:getTime()
  love.graphics.setFont(Font)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print(fullText[subs], x, y)
  for i = 1,#delayedText[subs] do
    if q >= t + i*speed then
      if delayedText[subs][i] then
        fullText[subs] = fullText[subs]..delayedText[subs][i]
        delayedText[subs][i] = false
      end
    end
  end
end


return textDraw
