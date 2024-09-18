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
  
  version "0.0.1"

  url "https://github.com/ankitk-me/zillabase/archive/refs/tags/#{version}.tar.gz"

  depends_on "openjdk@22"

  def install
    ENV["JAVA_HOME"] = Language::Java.java_home("22")

    system "./mvnw", "clean", "install", "--projects", "cli", "-DskipTests"
    
    libexec.install "cli/target/cli-develop-SNAPSHOT.jar"

    (bin/"zillabase").write <<~EOS
      #!/bin/bash
      exec java -jar "#{libexec}/cli-develop-SNAPSHOT.jar" "$@"
    EOS

    chmod "+x", bin/"zillabase"
  end
  
end
  