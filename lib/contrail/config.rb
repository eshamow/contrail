require 'contrail'
require 'inifile'

module Contrail
  class Config
    attr_accessor :data

    def initialize(path)
      file = IniFile.load(File.expand_path(path))
      raise(ArgumentError, "#{path} is not a valid INI file", caller) if file.nil?
      @data = file['default']
    end
  end
end
