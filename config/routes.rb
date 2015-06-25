Rails.application.routes.draw do
  root to: 'visitors#index'

  get 'test' ,to: 'testcascades#index'
  get 'create' ,to: 'createcascades#index'

  post 'upload_photo' , to: 'testcascades#upload_photo'

end
