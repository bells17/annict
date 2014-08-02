require 'spec_helper'

describe 'プロフィールページ' do
  let(:user)    { create(:registered_user) }
  let(:work)    { create(:work, :with_item) }
  let(:episode) { create(:episode, work: work) }

  before do
    user.checkins.create(episode: episode, comment: 'おもしろかったよ')

    visit "/users/#{user.username}"
  end

  it 'ページが表示されること' do
    expect(find('.profile h1')).to have_content(user.profile.name)
  end

  it 'アクティビティにチェックイン情報が表示されること', js: true do
    expect(find('.activities')).to have_content('おもしろかったよ')
  end
end

describe '見てる作品一覧ページ' do
  let(:user) { create(:registered_user) }

  before do
    login_as(user, scope: :user)
  end

  context '見てる作品があるとき' do
    let(:work) { create(:work, :with_item) }

    before do
      user.statuses.create(work: work, kind: :watching)

      visit "/users/#{user.username}/watching"
    end

    it '見てる作品が表示されること' do
      expect(page).to have_content(work.title)
    end
  end
end