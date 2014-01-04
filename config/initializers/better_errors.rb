if Rails.env.development?
  editor = ENV['EDITOR']

  mapping = {
    [:textmate, :txmt, :tm] => :textmate,
    [:sublime, :subl, :st] => :sublime,
    [:macvim, :mvim, :vim] => :macvim
  }

  mapping.each do |matches, value|
    matches.each do |m|
      if editor =~ /#{m.to_s}/
        BetterErrors.editor = value
      end
    end
  end
end
