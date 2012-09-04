#coding: utf-8

class ContactsController < ApplicationController
  before_filter :authenticate_user!, :contacts

  layout "admin"

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = contacts.page(params[:page]).per_page(18)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = contacts.find(params[:id])
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = contacts.new
  end

  # GET /contacts/1/edit
  def edit
    @contact = contacts.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = contacts.new(params[:contact])

    if @contact.save
      redirect_to contacts_path, notice: '联系人创建成功'
    else
      render action: "new"
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to contacts_path, notice: '联系人更新成功'
    else
      render action: "edit"
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_url
  end

  private

  def contacts
    @contacts = current_user.contacts
  end
end
