class DocumentsController < ApplicationController
  def index
    @document = Document.new
  end

  def create
    @document = Document.new document_params
    if @document.save
      redirect_to documents_path, notice: 'Document has been saved successfully'
    else
      render :index
    end
  end

  private

  def document_params
    params.require(:document).permit(:body)
  end
end
