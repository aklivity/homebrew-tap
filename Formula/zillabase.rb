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

class Zillabase < Formula
  desc "Zillabase"
  homepage "https://github.com/aklivity/zillabase"
  license "Aklivity Community License"
  
  version "0.3.0"

  url "https://github.com/aklivity/zillabase"

  depends_on "openjdk@21"
  depends_on "wget"

  def install
    ENV["JAVA_HOME"] = Language::Java.java_home("21")

    system "wget", "https://maven.packages.aklivity.io/io/aklivity/zillabase/cli/#{version}/cli-#{version}.jar"
    
    libexec.install "cli-#{version}.jar"

    (bin/"zillabase").write <<~EOS
      #!/bin/bash
      exec java -jar "#{libexec}/cli-#{version}.jar" "$@"
    EOS

    chmod "+x", bin/"zillabase"
  end
  
end
  