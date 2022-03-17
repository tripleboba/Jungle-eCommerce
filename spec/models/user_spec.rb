require 'rails_helper'

 RSpec.describe User, type: :model do
   describe 'Validations' do
     it "create user failed when password and password_confirmation fields don't match" do
       @user = User.create(
         first_name: "a",
         last_name: "b",
         email: "ab@gmail.com",
         password: "123456",
         password_confirmation: "123"
       )
       expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
     end

     it "emails must be unique" do
       User.create(
         first_name: "C",
         last_name: "D",
         email: "CD@gmail.com",
         password: "123456",
         password_confirmation: "123456"
       )
       @user = User.create(
         first_name: "C",
         last_name: "D",
         email: "CD@gmail.com",
         password: "123456",
         password_confirmation: "123456"
       )
       expect(@user.errors.full_messages).to include("Email has already been taken")
     end

     it 'create user without password_confirmation should fail' do
       @user = User.create(
         first_name: "B",
         last_name: "B",
         email: "bb@gmail.com",
         password: "123456",
         password_confirmation: nil
       )
       expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
     end

     it 'create user without first_name should fail' do
       @user = User.create(
         first_name: nil,
         last_name: "L",
         email: "nilL@gmail.com",
         password: "123456",
         password_confirmation: "123456"
       )
       expect(@user.errors.full_messages).to include("First name can't be blank")
     end

     it 'create user without last_name should fail' do
       @user = User.create(
         first_name: "F",
         last_name: nil,
         email: "fnil@gmail.com",
         password: "123456",
         password_confirmation: "123456"
       )
       expect(@user.errors.full_messages).to include("Last name can't be blank")
     end

     it 'create user without email should fail' do
       @user = User.create(
         first_name: "no",
         last_name: "e",
         email: nil,
         password: "123456",
         password_confirmation: "123456"
       )
       expect(@user.errors.full_messages).to include("Email can't be blank")
     end

     it 'password should be at least 6 characters' do
       @user = User.create(
         first_name: "6",
         last_name: "pass",
         email: "6pass@gmail.com",
         password: "12345",
         password_confirmation: "12345"
       )
       expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
     end
   end

   describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        first_name: "A",
        last_name: "B",
        email: "ab@gmail.com",
        password: "123456",
        password_confirmation: "123456"
      )
    end

    it "return an instance of user if email and password match" do
      res = User.authenticate_with_credentials("ab@gmail.com", "123456")
      expect(res).to be_an_instance_of(User) 
    end

    it "return nil if email and password don't match" do
      res = User.authenticate_with_credentials("ab@gmail.com", "123123")
      expect(res).to be nil 
    end

    it "still authenticated successfully even there are spaces before and/or after email address" do
      res = User.authenticate_with_credentials("   ab@gmail.com   ", "123456")
      expect(res).to be_an_instance_of(User) 
    end

    it "still authenticated successfully even the email address is in wrong case" do
      res = User.authenticate_with_credentials("Ab@gmAil.Com", "123456")
      expect(res).to be_an_instance_of(User) 
    end

   end
 end