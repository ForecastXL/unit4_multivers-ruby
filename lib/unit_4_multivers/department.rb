module Unit4Multivers
  class Client
    def department_nvl(opts = {})
      required = [:database]
      check_required_parameters(required, opts)

      get "/#{opts.fetch(:database)}/DepartmentNVL", opts
    end
  end
end






