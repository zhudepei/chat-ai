class FaqsController < ApplicationController
  before_action :set_faq, only: %i[ show update destroy ]

  def index
    @faqs = Faq.page(params[:page]).per(params[:limit])
  end

  def show
  end

  def create
    @faq = Faq.new(faq_params)

    ActiveRecord::Base.transaction do
      if @faq.save
        insert_milvus # 插入向量数据库
        render :show, status: :ok, location: @faq
      else
        render json: @faq.errors, status: :bad_request
      end
    end
  end

  def update
    if @faq.update(faq_params)
      render :show, status: :ok, location: @faq
    else
      render json: @faq.errors, status: :bad_request
    end
  end

  def destroy
    @faq.destroy!
    head :ok
  end

  private

  def set_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:question, :answer, :category)
  end

  # TODO 插入向量数据库
  def insert_milvus

  end
end
