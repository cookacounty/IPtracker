#module IPtracker
#  class TaskAbortedByUserError < StandardError; end
#end

namespace :iptracker do
  
  #def ask_to_continue
  #  puts "Continue (yes/no)"
  #  answer = gets
  #  raise IPtracker::TaskAbortedByUserError unless answer == "yes"
  #end

  # Check which OS is running
  #
  # It will primarily use lsb_relase to determine the OS.
  # It has fallbacks to Debian, SuSE, OS X and systems running systemd.
  def os_name
    os_name = run("lsb_release -irs")
    os_name ||= if File.readable?('/etc/system-release')
                  File.read('/etc/system-release')
                end
    os_name ||= if File.readable?('/etc/debian_version')
                  debian_version = File.read('/etc/debian_version')
                  "Debian #{debian_version}"
                end
    os_name ||= if File.readable?('/etc/SuSE-release')
                  File.read('/etc/SuSE-release')
                end
    os_name ||= if os_x_version = run("sw_vers -productVersion")
                  "Mac OS X #{os_x_version}"
                end
    os_name ||= if File.readable?('/etc/os-release')
                  File.read('/etc/os-release').match(/PRETTY_NAME=\"(.+)\"/)[1]
                end
    os_name.try(:squish!)
  end
  
end