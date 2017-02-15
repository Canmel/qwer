# coding: utf-8

module Qwer
  require "qwer/version"

  module Qwer
    # Your code goes here...
    def self.sayhi
      puts "hello world"
    end
    module Helpers
      def table_seach
        '<h5 class="page-header">查询条件</h5>'
        '<div class="dataTables_wrapper form-inline">
        <div>
          <form class="pjax-form" id="user_search" action="/users" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="✓">
            <label class="control-label" for="q_邮箱：">邮箱：</label>
            <input class="form-control" type="search" name="q[email_cont]" id="q_email_cont">
            <a class="btn btn-success green" href="/users/new">新增</a>
            <button type="submit" class="btn btn-info" data-toggle="modal" data-target="#search_model">查询</button>
          </form>
        </div>
      </div>'
      end
    end
  end

end