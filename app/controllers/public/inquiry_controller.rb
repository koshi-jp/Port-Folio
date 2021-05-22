class Public::InquiryController < ApplicationController
  def index
    # 入力画面を表示
    @inquiry = Inquiry.new
    render :action => 'index'
  end

  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.send_mail(@inquiry).deliver

    # 完了画面を表示
    render :action => 'thanks'
  end

  private

  def inquiry_params
    list = [
      :name,
      :email,
      :message,
    ]
    params.require(:inquiry).permit(list)
  end
end
