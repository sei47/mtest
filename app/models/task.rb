class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  belongs_to :user
  
  enum priority: { 高: 0,中: 1,低: 2 }
  priority_order = [0, 1, 2]
  scope :order_by_priority, -> {
      order_by = []
      priority_order.each { |priority| order_by << "priority=#{priority} DESC" }
      order(order_by.join(", "))
  }
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
