class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :landing_page_cover_photo

      t.timestamps null: false
    end

    SiteConfig.create!
  end
end
