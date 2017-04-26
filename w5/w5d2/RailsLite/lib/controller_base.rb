require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'byebug'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, params = req.params)
    @req = req
    @res = res
    @params = params
    @req.params.merge(@params)
    session
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise('Already built a response') if already_built_response?
    @res.location = url
    @res.status = 302
    @already_built_response = true
    @session.store_session(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise('Already built a response') if already_built_response?
    @res['Content-Type'] = content_type
    @res.write(content)
    @res.finish
    @already_built_response = true
    @session.store_session(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    raw_content = read_file_contents(template_name)
    parsed_content = ERB.new(raw_content).result(binding)

    render_content(parsed_content, 'text/html')
  end

  def read_file_contents(template_name)
    folder_path = File.absolute_path('.')
    file = File.open(
      "#{folder_path}/views/#{controller_folder}/#{template_name}.html.erb"
    )
    contents = file.read
    file.close
    contents
  end

  def controller_folder
    name = self.class.name
    klass_name = /^.*(?=(Controller))/.match(name)[0]
    klass_name = klass_name.downcase
    "#{klass_name}_controller"
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
  end
end
