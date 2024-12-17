#
# Copyright 2021-2024 Aklivity Inc.
#
# Aklivity licenses this file to you under the Apache License,
# version 2.0 (the "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at:
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

class Zilla < Formula
  desc "A multi-protocol, event-native proxy. Securely interface web apps, IoT clients, & microservices to Apache Kafka® via declaratively defined, stateless APIs."
  homepage "https://github.com/aklivity/zilla"
  license "Aklivity Community License"

  version "0.9.111"

  url "https://raw.githubusercontent.com/aklivity/zilla/#{version}/cloud/docker-image/src/main/docker/zpm.json.template"

  depends_on "wget"
  depends_on "openjdk@21"

  def install
    system "wget", "https://maven.packages.aklivity.io/io/aklivity/zilla/manager/#{version}/manager-#{version}.jar"

    template_contents = File.read("zpm.json.template")
    updated_contents = template_contents.gsub("${VERSION}", version)

    File.open("zpm.json", "w") { |file| file.puts updated_contents }

    system "java", "-jar", "manager-#{version}.jar", "wrap"

    system "./zpmw", "install", "--debug", "--instrument"

    libexec.install Dir["zilla"] + [".zpm"]
    bin.install_symlink libexec/"zilla"
    bin.install_symlink libexec/".zpm"
  end

end

