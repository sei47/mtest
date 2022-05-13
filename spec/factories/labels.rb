FactoryBot.define do
  factory :label do
    name { 'label_test' }
  end
  factory :second_label, class: Label do
    name { 'label_test2' }
  end
end
