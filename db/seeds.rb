# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:

#commercials: Cms::HashList
#commercials.top: Cms::HashList
#commercials.top.banner: Cms::NamedBlock, name = 'banner'
#commercials.top.side: Cms::HashList
#commercials.top.side.banner: NamedBlock, name = 'banner'
#commercials.top.side.bonusImage: NamedImage, name = 'bonusImage'
#commercials.top.commercials.images: ImageList, name = 'images'




Cms::HashList.destroy_all
Cms::NamedBlock.destroy_all
Cms::NamedImage.destroy_all
Cms::ImageList.destroy_all
Cms::BlockList.destroy_all
Cms::List.destroy_all
Cms::ListItem.destroy_all
Cms::Image.destroy_all
Cms::Block.destroy_all
Cms::Template.destroy_all

commercials = Cms::HashList.create(:name => "commercials")
top = Cms::HashList.create(:name => "top", :composite_hash => commercials)
side = Cms::HashList.create(:name => "side", :composite_hash => top)


banner = Cms::NamedBlock.create(:name => "banner",  :composite_hash => side)
bonusImage =  Cms::NamedImage.create(:name => "bonusImage",  :composite_hash => side)
sideImage =  Cms::NamedImage.create(:name => "sideImage",  :composite_hash => top)

images =  Cms::ImageList.create(:name => "images",  :composite_hash => side)
blocks =  Cms::BlockList.create(:name => "blocks",  :composite_hash => side)

side_list =  Cms::List.create(:name => "side_list")
sub_list =  Cms::List.create(:name => "sub_list", :list => side_list)
sub_list_item =  Cms::ListItem.create(:name => "sub_list_item", :list => side_list)


image1 = Cms::Image.create(:title => "logoImage", :named_image => bonusImage, :image_list_ids => [images.id])
image2 = Cms::Image.create(:title => "bannerImage", :named_image => sideImage )

block1 = Cms::Block.create(:title => "block1", :block_list_ids => [blocks.id])
block2 = Cms::Block.create(:title => "block2", :named_block =>  banner)




block3 = Cms::Block.create(:title => "block3", :summary => "test summary", :content => "test content")

Cms::Template.create!(name: "small-block", 
templatable: block3,  
content: %{
<p> {{ title }} </p>
<p> {{ summary }} </p>
<p> {{ content }} </p>
}
)

Cms::Layout.create!(name: "layout1",
template: %{
<p>Layout Name: {{ name }} </p>
{{content_for_layout}}
}
)


# http://localhost:3000/cms/api/v1/lists/commercials?type=hash
# http://localhost:3000/cms/api/v1/lists/blocks?type=block
# http://localhost:3000/cms/api/v1/lists/images?type=image

# http://localhost:3000/cms/api/v1/lists/side_list?type=list
