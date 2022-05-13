require 'rails_helper'
# bundle exec rspec spec/system/label_spec.rb
RSpec.describe 'ラベル機能', type: :system do
  before do
    @task = FactoryBot.create(:task, title: "test")
    @second_task = FactoryBot.create(:second_task, user_id: @task.user_id)
    FactoryBot.create(:second_label)
    visit new_session_path
    fill_in 'session[email]', with:'123456@email.com'
    fill_in 'session[password]', with: '4'
    click_on 'ログイン'
  end
  describe '新規作成' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        visit new_task_path
        expect(page).to have_content 'label_test2'
      end
    end
    context 'タスクを新規作成した場合' do
      it '付与したラベルが表示される' do
        visit tasks_path
        expect(page).to have_content 'label_test'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクに紐付したラベルが表示される' do
         visit task_path(@task.id)
         expect(page).to have_content 'label_test'
       end
     end
  end

  describe '編集機能' do
    context '作成済みタスクのラベルを編集した場合' do
      it '編集したラベルが一覧に表示される' do
        visit edit_task_path(@task.id)
        check 'label_test2'
        click_on '更新する'
        visit tasks_path
        expect(page).to have_content 'label_test2'
      end
    end
  end
  describe '検索機能' do
    context '一覧画面で検索するラベルを指定した場合' do
      it "ラベルを含むタスクが表示される" do
        visit edit_task_path(@second_task.id)
        check 'label_test2'
        click_on '更新する'
        visit tasks_path
        select 'label_test', from: 'label_id'
        click_on '検索'
        test_list = all('.task_row')
        expect(test_list).to_not include 'label_test2'
      end
    end
  end
end
