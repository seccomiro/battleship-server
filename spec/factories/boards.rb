FactoryBot.define do
  factory :board do
    player { nil }
    cells { [] }
    public_cells { [] }
  end
end
