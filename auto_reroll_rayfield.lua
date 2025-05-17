-- Carrega a Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Cria a janela principal
local Window = Rayfield:CreateWindow({
   Name = "Auto Reroll GUI",
   LoadingTitle = "Carregando...",
   ConfigurationSaving = {
      Enabled = false
   }
})

-- Cria a aba Rollback
local RollbackTab = Window:CreateTab("Rollback", 4483362458)

-- Variáveis de controle
local running = false
local metodoSelecionado = "Trait"
local traitBom = "Sovereign"

-- Dropdown para escolher método
RollbackTab:CreateDropdown({
   Name = "Method",
   Options = {"Trait", "Universal"},
   CurrentOption = "Trait",
   Flag = "MethodDropdown",
   Callback = function(Option)
      metodoSelecionado = Option
      print("Método selecionado:", Option)
   end
})

-- Função de reroll automático
local function autoReroll()
   local player = game.Players.LocalPlayer
   local gui = player:WaitForChild("PlayerGui")

   local function clickButton(texto)
       for _, v in pairs(gui:GetDescendants()) do
           if v:IsA("TextButton") and string.lower(v.Text) == string.lower(texto) then
               v:Activate()
               return true
           end
       end
       return false
   end

   local function getTrait()
       for _, v in pairs(gui:GetDescendants()) do
           if v:IsA("TextLabel") and v.Text == traitBom then
               return v.Text
           end
       end
       return nil
   end

   while running do
       wait(2)
       clickButton("Reroll")
       wait(2)
       local trait = getTrait()
       if trait == traitBom then
           print("🎉 Trait bom encontrado:", trait)
           running = false
           break
       else
           clickButton("Rollback")
       end
   end
end

-- Toggle para ativar/desativar
RollbackTab:CreateToggle({
   Name = "Enable",
   CurrentValue = false,
   Callback = function(Value)
      running = Value
      if running then
         print("🔁 Auto reroll iniciado")
         spawn(autoReroll)
      else
         print("⏹️ Auto reroll parado")
      end
   end
})

-- Botão manual
RollbackTab:CreateButton({
   Name = "Press After Done",
   Callback = function()
      print("Botão manual acionado!")
   end,
})
