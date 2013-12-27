public

def capture_stdout
  real_stdout, $stdout = $stdout, StringIO.new
  yield
  $stdout.string
ensure
  $stdout = real_stdout
end

def capture_stderr
  real_stderr, $stderr = $stderr, StringIO.new
  yield
  $stderr.string
ensure
  $stderr = real_stderr
end
