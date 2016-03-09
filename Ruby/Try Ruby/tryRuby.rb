Popup.make do
  h1 "Comics on the web"
  list do
    comics.each do |name, url|
      link name, url
    end
  end
end