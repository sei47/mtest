require 'rails_helper'
# bundle exec rspec spec/system/user_spec.rb
RSpec.describe 'ユーザーログイン機能', type: :system do
  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      it 'ユーザーページが表示される' do
        visit new_user_path
        fill_in 'user[name]', with:'A'
        fill_in 'user[email]', with:'123456@email.com'
        fill_in 'user[password]', with: '4'
        fill_in 'user[password_confirmation]', with: '4'
        click_on '登録'
        expect(page).to have_content 'A'
      end
    end
  end
  describe 'ログイン管理機能' do
    context 'ログインせず一覧画面に遷移しようとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end

    context 'ログインした場合' do
      before do
        @test = FactoryBot.create(:user)
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with:'456@email.com'
        fill_in 'session[password]', with: '5'
        click_on 'ログイン'
      end
      it "ユーザーページが表示される" do
        expect(page).to have_content 'B'
      end

      it "他人のユーザーページに行こうとするとタスク一覧に遷移する" do
        visit user_path(@test.id)
        expect(page).to have_content 'タスク一覧'
      end
    end

    context 'ログアウトボタンを押した場合' do
      before do
        @test = FactoryBot.create(:user)
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with:'456@email.com'
        fill_in 'session[password]', with: '5'
        click_on 'ログイン'
      end
      it "ログアウトできる" do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理ユーザー機能' do
    before do
      @test = FactoryBot.create(:user)
      @common = FactoryBot.create(:second_user)
      visit new_session_path
      fill_in 'session[email]', with:'123456@email.com'
      fill_in 'session[password]', with: '4'
      click_on 'ログイン'
    end
    context '管理画面にアクセスした場合' do
      it '管理画面を表示できる' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
    end

    context '一般ユーザーで管理画面にアクセスした場合' do
      it 'タスク一覧画面に遷移する' do
        click_on 'Logout'
        visit new_session_path
        fill_in 'session[email]', with:'456@email.com'
        fill_in 'session[password]', with: '5'
        click_on 'ログイン'
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end

    context '管理ユーザーが新規登録した場合' do
      it '新しいユーザーを登録できる' do
        visit new_admin_user_path
        fill_in 'user[name]', with:'C'
        fill_in 'user[email]', with:'741@email.com'
        fill_in 'user[password]', with: '9'
        fill_in 'user[password_confirmation]', with: '9'
        click_on '登録'
        expect(page).to have_content 'C'
      end
    end
    context '管理ユーザーが他ユーザーの詳細画面に遷移した場合' do
      it 'ユーザーの詳細画面が表示される' do
        visit user_path(@common.id)
        expect(page).to have_content 'B'
      end
    end

    context '管理ユーザーがユーザーの編集画面に遷移した場合' do
      it 'ユーザーの情報が編集できる' do
        visit edit_admin_user_path(@test.id)
        fill_in 'user[name]', with:'D'
        click_on '登録'
        expect(page).to have_content 'D'
      end
    end

    context '管理ユーザーがユーザーを削除した場合' do
      it 'ユーザーの情報が削除できる' do
        visit admin_users_path
        page.accept_confirm do
          all('table tr').last.click_on '削除する'
        end
        expect(page).to have_content '削除しました'
      end
    end
  end
end
