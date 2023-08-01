# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
    rescue_from ActionController::ParameterMissing, with: :bad_request
  end

  private

  def command_failure(err)
    @errors = [error(err.http_code, err.message)]
    render 'errors/errors', status: err.http_code
  end

  def bad_request(error)
    @errors = [error(:bad_request, error.message)]
    render 'errors/errors', status: :bad_request
  end

  def invalid_record(invalid)
    @errors = invalid.record.errors.map { |error| error(:invalid_record, "#{error.attribute} #{error.message}") }
    render 'errors/errors', status: :unprocessable_entity
  end

  def not_found
    @errors = [error(:not_found, "Requested page #{request.path} does not exist")]
    render 'errors/errors', status: :not_found
  end

  def error(code, detail)
    OpenStruct.new({
                     code: code,
                     detail: detail
                   })
  end
end
