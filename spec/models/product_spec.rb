require 'rails_helper'

 RSpec.describe Product, type: :model do
   before(:each) do
     @category = Category.create(name: "Comic")
   end

   describe 'Validations' do
     it 'create product with all fields should succeed' do
       @product = Product.create(
         name: "happy water",
         quantity: 2,
         category: @category,
         price: 13
       )
       expect(@product.errors.full_messages).to eq([])
     end

     it 'create product without name should fail' do
       @product = Product.create(
         price: 13,
         quantity: 2,
         category: @category
       )
       expect(@product.errors.full_messages).to include("Name can't be blank")
     end

     it 'create product without price should fail' do
       @product = Product.create(
         name: "happy water",
         quantity: 2,
         category: @category
       )
       expect(@product.errors.full_messages).to include("Price can't be blank")
     end

     it 'create product without quantity should fail' do
       @product = Product.create(
         name: "happy water",
         price: 13,
         category: @category
       )
       expect(@product.errors.full_messages).to include("Quantity can't be blank")
     end

     it 'create product without category should fail' do
       @product = Product.create(
         name: "happy water",
         price: 13,
         quantity: 2,
       )
       expect(@product.errors.full_messages).to include("Category can't be blank")
     end
   end
 end