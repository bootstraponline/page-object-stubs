module Page
  class AngularPage
    include PageObject

    page_url 'https://angularjs.com/'

    link 'download_button', css: 'a.btn.btn-large.btn-primary'
  end
end

# HTML tag -> method reference:
# https://github.com/cheezy/page-object/wiki/Methods-for-HTML-Tags
