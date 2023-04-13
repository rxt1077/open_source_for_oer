require 'asciidoctor'
require 'asciidoctor-diagram'
require 'asciidoctor-revealjs'
require 'webrick'

outputdir = 'output'
imagesdir = 'images'
revealjs_theme = 'black'
revealjsdir = 'https://cdn.jsdelivr.net/npm/reveal.js@3.9.2'
revealjs_customcss = 'custom.css'

desc 'Cleans and sets up output/slides directory'
task :slidesdirs do
  rm_rf "#{outputdir}/slides"
  mkdir_p "#{outputdir}/slides"
  cp_r "slides/#{imagesdir}", "#{outputdir}/slides/"
  cp "slides/#{revealjs_customcss}", "#{outputdir}/slides/"
end

desc 'Converts slides/*.adoc into reveal.js presentations'
task :slides => [:slidesdirs] do
  files = FileList['slides/*.adoc']
  files.each do |file|
    puts "Converting #{file}..."
    Asciidoctor.convert_file(
      file,
      to_dir: "#{outputdir}/slides",
      backend: 'revealjs',
      safe: :unsafe,
      attributes: "revealjsdir=#{revealjsdir} " + 
                  "revealjs_theme=#{revealjs_theme} " +
                  "imagesdir=#{imagesdir} " +
                  "source-highlighter=rouge " +
                  "customcss=#{revealjs_customcss} " +
                  "icons=font",
    )
  end
end

desc 'Cleans and sets up output/example directory'
task :exampledirs do
  rm_rf "#{outputdir}/example"
  mkdir_p "#{outputdir}/example"
  cp_r "example/#{imagesdir}", "#{outputdir}/example/"
end

desc 'Converts example/*.adoc into HTML5 files'
task :example => [:exampledirs] do
  files = FileList['example/*.adoc']
  files.each do |file|
    puts "Converting #{file}..."
    Asciidoctor.convert_file(
      file,
      to_dir: "#{outputdir}/example",
      backend: 'html5',
      safe: :unsafe,
      attributes: "imagesdir=#{imagesdir} icons=font source-highlighter=rouge",
    )
  end
end

desc 'Deploys the output directory to https://web.njit.edu/~rxt1077/open_source_for_oer'
task :deploy do
    sh "rsync --delete -av #{outputdir}/ rxt1077@afs22.njit.edu:public_html/open_source_for_oer/"
end

desc 'Runs an HTTP server to serve the /docs/#{outputdir} directory'
task :serve do
  server = WEBrick::HTTPServer.new :Port => 8080, :DocumentRoot => "/docs/#{outputdir}"
  trap 'INT' do server.shutdown end
  server.start
end

desc 'Builds all documents'
task :default => [:slides, :example]
