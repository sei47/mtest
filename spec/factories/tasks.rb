FactoryBot.define do
  factory :task do
    association :user
    title { 'test_title' }
    content { 'test_content' }
    deadline { '2022/04/13' }
    status { '未着手' }
    priority { '高' }

    after(:build) do |task|
      label = create(:label)
      task.marks << build(:mark, task: task, label: label)
    end
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '2022/04/18' }
    status { '未着手' }
    priority { '高' }
  end
end
