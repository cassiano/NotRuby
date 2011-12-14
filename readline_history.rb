# Code based on http://stackoverflow.com/questions/2065923/irb-history-not-working
module ReadlineHistory
  HISTORY_FILE      = "~/.notruby_history"
  MAX_HISTORY_SIZE  = 100

  def self.load_history
    # Setup permanent history.
    begin
      history_file = File::expand_path(HISTORY_FILE)
    
      if File::exists?(history_file)
        lines = IO::readlines(history_file).collect(&:chomp)
        puts "Read #{lines.size} saved history commands from '#{history_file}'." if $VERBOSE
        Readline::HISTORY.push(*lines)
      else
        puts "History file '#{history_file}' was empty or non-existant." if $VERBOSE
      end
    
      Kernel::at_exit do
        lines = Readline::HISTORY.to_a.reverse.uniq.reverse.last(MAX_HISTORY_SIZE)
        puts "Saving #{lines.length} history lines to '#{history_file}'." if $VERBOSE
        File::open(history_file, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
      end
    rescue => e
      puts "Error when configuring permanent history: #{e}" if $VERBOSE
    end
  end
end
