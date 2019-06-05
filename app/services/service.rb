module Service
  def call(args = {})
    if args.present?
      new(**args).call
    else
      new.call
    end
  end
end