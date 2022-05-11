require 'rails_helper'
# bundle exec rspec spec/system/task_spec.rb
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task, title: "test")
    FactoryBot.create(:second_task, user_id: @task.user_id)
    visit new_session_path
    fill_in 'session[email]', with:'123456@email.com'
    fill_in 'session[password]', with: '4'
    click_on 'ログイン'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with:'task_test'
        fill_in 'task[content]', with:'task_test'
        fill_in 'task_deadline', with: '2022/04/13'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        click_on '登録する'
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit new_task_path
        fill_in 'task[title]', with:'task_test'
        fill_in 'task[content]', with:'task_test'
        fill_in 'task_deadline', with: '2022/04/13'
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        click_on '登録する'
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it "新しいタスクが一番上に表示される" do
        visit tasks_path
        task_list = first('.task_row')
        expect(page).to have_content 'test'
      end
    end

    context 'ソートボタンを押した場合' do
      it "期限が降順で表示される" do
        visit tasks_path
        click_on '終了期限'
        task_list = first('.task_row')
        expect(page).to have_content '2022-04-18'
      end
    end
  end
  describe '検索機能' do
    context 'タイトルで曖昧検索した場合' do
      it '検索キーワードを含むタスクで絞り込める' do
        visit tasks_path
        fill_in 'title_search', with:'test'
        click_on '検索'
        expect(page).to have_content 'test'
      end
    end
    context 'ステータス検索した場合' do
      it '完全一致するタスクで絞り込める' do
        visit tasks_path
        select '未着手', from: 'status_search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルの曖昧検索とステータス検索をした場合' do
      it '検索キーワードを含み、ステータスに完全一致するタスクで絞り込める' do
        visit tasks_path
        fill_in 'title_search', with:'test'
        select '未着手', from: 'status_search'
        expect(page).to have_content 'test'
      end
    end
    context '優先順位でソートしたとき' do
      it '優先度が高い順にソートされる' do
        visit tasks_path
        task_list = all('.task_row')
        click_on '優先度'
        test_list = all('.task_row')
        expect(task_list[0]).to eq test_list[0]
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(@task.id)
         expect(page).to have_content 'test'
       end
     end
  end
end
