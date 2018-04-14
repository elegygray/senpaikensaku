class Information < ApplicationRecord
  include SearchCop
  belongs_to :user
  validates :user_id, presence: true
  validates :highschool, presence: true
  validates :university, presence: true
  validates :faculty, presence: true
  validates :content, presence: true
  
  search_scope :highschool_search do
    attributes :highschool
  end
  
  search_scope :highschool_university_search do
    attributes :highschool, :university
  end
  
  search_scope :highschool_faculty_search do
    attributes :highschool, :faculty
  end
  
  search_scope :highschool_content_search do
    attributes :highschool, :content
  end
  
  search_scope :highschool_university_faculty_search do
    attributes :highschool, :university, :faculty
  end
  
  search_scope :highschool_faculty_content_search do
    attributes :highschool, :faculty, :content
  end
  
  search_scope :university_faculty_content_search do
    attributes :university, :faculty, :content
  end
  
  search_scope :highschool_university_content_search do
    attributes :highschool, :university, :content
  end
  
  
  search_scope :university_search do
    attributes :university
  end
  
  search_scope :university_faculty_search do
    attributes :university, :faculty
  end
  
  search_scope :university_content_search do
    attributes :university, :content
  end
  
  search_scope :faculty_search do
    attributes :faculty
  end
  
  search_scope :faculty_content_search do
    attributes :faculty, :content
  end
  
  search_scope :content_search do
    attributes :content
  end
  
  search_scope :all_search do
    attributes :university, :faculty, :highschool, :content
  end
end
