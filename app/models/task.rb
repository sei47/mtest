class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true

  def self.search(title_search, status_search)
    if title_search.present? and status_search.present?
      @task = Task.where('title LIKE ?', "%#{title_search}").where('status LIKE ?', "#{status_search}")
    elsif title_search.present?
      @task = Task.where('title LIKE ?', "%#{title_search}")
    elsif status_search.present?
      @task = Task.where('status LIKE ?', "#{status_search}")
    end
  end
end
# if params[:title_search].present? and params[:status_search].present?
#   @task = Task.where('title LIKE ?', "%#{params[:title_search]}").where('status LIKE ?', "#{params[:status_search]}")
# elsif params[:title_search].present?
#   @task = Task.where('title LIKE ?', "%#{params[:title_search]}")
# elsif params[:status_search].present?
#   @task = Task.where('title LIKE ?', "%#{params[:status_search]}")
# end
# if title_search.present? and status_search.present?
#   @task = Task.where('title LIKE ?', "%#{title_search}").where('status LIKE ?', "#{status_search}")
#   binding.irb
# elsif title_search.present?
#   @task = Task.where('title LIKE ?', "%#{title_search}")
# elsif status_search.present?
#   @task = Task.where('status LIKE ?', "#{status_search}")
#   binding.irb
# end
# binding.irb
# @tasks = @tasks.where('title LIKE ?', "%#{title_search}")
# @tasks = @tasks.where('status LIKE ?', "%#{status_search}") if status_search.present?
