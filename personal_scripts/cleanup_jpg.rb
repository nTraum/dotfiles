# Usage: ruby cleanup_jpg.rb PATH
# Trashes JPG files from PATH if a corresponding RAW file with the same basename cannot be found.
# Useful if you shoot JPG+RAWs and then sort out RAWs only in your image library (e.g. darktable).

require 'fileutils'

JPG_GLOB = ".{jpg,jpeg,JPG,JPEG}"
RAW_GLOB = ".{ARW,arw}"
TRASH_DIR = (File.expand_path("~/.local/share/Trash/")) + "/"

path = ARGV[0]

abort("path missing as first argument") unless path

jpgs = Dir.glob(File.join(path, "*#{JPG_GLOB}"))

to_be_deleted = jpgs.select do |jpg|
  basename = File.basename(jpg, File.extname(jpg))

  (Dir.glob(File.join(path, basename + RAW_GLOB))).empty?
end

abort("No JPGs found that were missing RAW files, exiting...") if to_be_deleted.empty?

puts "The following JPGs do not have corresponding RAW files:"
to_be_deleted.each { |jpg| puts jpg }

puts "Trash #{to_be_deleted.count} files? (yes/NO):"
answer = STDIN.gets.chomp

if (answer == "yes" || answer == "y")
  to_be_deleted.each{ |jpg| FileUtils.mv(jpg, TRASH_DIR) }
end
