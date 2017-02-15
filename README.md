# Qwer

qwer一招带走你的index

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qwer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qwer

## Usage

- 在`index.html`适当的位置添加代码

```
    model = Qwer::Tmodel.new('users', 10, 1)   
    

    第一个参数：　当前业务
    第二个参数：　每页显示数量
    第三个参数：  当前页数
```

- 调用方法table_seach,创建查询项
```
    model.table_seach({
                          action: '/users',         ## 提交地址（默认为当前业务）
                          method: 'get',            ## 请求方式（默认为get）
                          form_class: 'form-inline text-right',     ## 表单样式：　默认（pjax-form）
                          'charset': 'UTF-8',       ## 编码（默认字符集UTF-8）
                          new: '/companies/new'     ## 新建按钮指向地址（可选,不传则没有新建按钮）
                      }, {
                          'q[name_cont]': '名称',    ## 查询项name及其显示名称
                      })
```

- 调用方法table_data,创建数据表
```
 model.table_data({        car_no: '车牌号',
                          'driver.name': '司机',
                          status_i18n: '状态',
                         }, {
                             edit: {name: '编辑', css: 'label label-success'},
                             del: {name: '删除', css: 'label label-danger'},
                             business: '<a class="label label-success" data-confirm="我的id是??" href="/companies/??/edit">其他</a>'
                         }, @cars )

第一个参数：  Hash  |  数据表字段  | 格式：　{字段或方法名：　‘显示表头’, ...}
第二个参数：  Hash  |  数据操作项  | 格式：　{'预设操作按钮编辑（edit）和删除(del)': {name和css属性}}
第三个参数：  数据表数据 
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/qwer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

