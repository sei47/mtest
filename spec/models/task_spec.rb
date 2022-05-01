require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト', deadline: '2022/04/13')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '', deadline: '2022/04/13')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', deadline: '2022/04/13')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample") }
    context 'タイトルで曖昧検索した場合' do
      it "検索キーワードを含むタスクで絞り込める" do
        expect(Task.search('task', nil)).to include(task)
        expect(Task.search('task', nil)).not_to include(second_task)
        expect(Task.search('task', nil).count).to eq 1
      end
    end
    context 'ステータス検索した場合' do
      it "完全一致するタスクで絞り込める" do
        expect(Task.search(nil, '未着手')).to include(task)
        expect(Task.search(nil, '未着手')).not_to include(second_task)
        expect(Task.search(nil, '未着手').count).to eq 1
      end
    end
    context 'タイトルの曖昧検索とステータス検索をした場合' do
      it "検索キーワードを含み、ステータスに完全一致するタスクで絞り込める" do
        expect(Task.search('task', '未着手')).to include(task)
        expect(Task.search('task', '未着手')).not_to include(second_task)
        expect(Task.search('task', '未着手').count).to eq 1
      end
    end
  end
end
