#
# this provider inherits from 'apt' itself .. 
# basically it provides the functionality to call the apt provider with options
#
# main usage: it is a workarround to properly install backports without the need of pinning the whole dependency tree
#
# still awaiting upstream merge: http://projects.puppetlabs.com/issues/2406#change-65551
#
# (C) 2012 - Patrick Ringl
#
Puppet::Type.type(:package).provide :aptbpo, :parent => :apt, :source => :apt do
  # Provide sorting functionality
  include Puppet::Util::Package

  desc "Enhanced Package management via `apt-get`."

  has_feature :install_options
  has_feature :versionable
  def install
    self.run_preseed if @resource[:responsefile]
    should = @resource[:ensure]

    checkforcdrom
    cmd = %w{-q -y}

    if resource[:install_options]
      resource[:install_options].each_pair do |k,v|
        cmd << [k,v]
      end
    end

    keep = ""
    if config = @resource[:configfiles]
      if config == :keep
        cmd << "-o" << 'DPkg::Options::=--force-confold'
      else
        cmd << "-o" << 'DPkg::Options::=--force-confnew'
      end
    end

    str = @resource[:name]
    case should
    when true, false, Symbol
      # pass
    else
      # Add the package version and --force-yes option
      str += "=#{should}"
      cmd << "--force-yes"
    end

    cmd << :install << str

    aptget(*cmd)
  end

end
