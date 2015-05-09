AST debugging info.

```ruby
=begin
    (send nil :page_url
      (str "http://www.thegymnasium.com/"))

      page_url 'http://www.thegymnasium.com/'

    # ---

    (send nil :button
      (sym :sign_in)
      (hash
        (pair
          (sym :xpath)
          (str "//*[@id=\"drop001\"]"))))

    button :sign_in, xpath: '//*[@id="drop001"]'

    # ---

    (send nil :text_field
      (sym :user_name)
      (hash
        (pair
          (sym :id)
          (str "user_name"))))

    text_field :user_name, :id => 'user_name'

    # ---

    (send nil :text_field
      (sym :password)
      (hash
        (pair
          (sym :css)
          (str "#loginfrm > fieldset > div.col > #user_pass"))))

    text_field :password, :css => '#loginfrm > fieldset > div.col > #user_pass'

    # ---

    (send nil :button
      (sym :submit_sign_in)
      (hash
        (pair
          (sym :css)
          (str "#loginfrm > fieldset > div.btn-holder > input.btn"))))))]

    button :submit_sign_in, css: '#loginfrm > fieldset > div.btn-holder > input.btn'
=end
```
