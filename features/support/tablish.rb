def tableish(css, selector=nil)
  if selector
    all(css).map{|r| selector.call(r)}
  else
    rows = find(css).all('tr')
    rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  end
end
