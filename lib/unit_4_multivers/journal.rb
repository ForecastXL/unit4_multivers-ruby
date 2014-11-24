module Unit4Multivers
  class Client
    # GET api/{database}/JournalInfo/{journalId}?fiscalYear={fiscalYear}
    # Gets the specified JournalInfo.
    # GET api/{database}/JournalInfo/{journalId}
    # Gets the specified JournalInfo.

    def journal_info(opts = {})
      required = [:database, :journal_id]
      check_required_parameters(required, opts)
      get "/#{opts.fetch(:database)}/JournalInfo/#{opts.fetch(:journal_id)}", opts
    end


    # GET api/{database}/JournalInfoList?fiscalYear={fiscalYear}
    # Gets a list of JournalInfo that matches the specified criteria
    # GET api/{database}/JournalInfoList
    # Gets a list of JournalInfo that matches the specified criteria

    def journal_info_list(opts = {})
      required = [:database]
      check_required_parameters(required, opts)

      get "/#{opts.fetch(:database)}/JournalInfoList", opts
    end

    # GET api/{database}/JournalEntryLineInfoList/{fiscalYear}/{period}/{accountid}
    # Gets a list of JournalEntryLineInfo that matches the specified criteria

    def journal_entry_line_info_list(opts = {})
      required = [:database, :fiscal_year, :period, :account_id ]
      check_required_parameters(required, opts)

      get "/#{opts.fetch(:database)}/JournalEntryLineInfoList/#{opts.fetch(:fiscal_year)}/#{opts.fetch(:period)}/#{opts.fetch(:account_id)}", opts
    end
  end
end