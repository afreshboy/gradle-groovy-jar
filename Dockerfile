# 根据版本
FROM gradle:jdk8 as builder

# 指定构建过程中的工作目录
WORKDIR /opt/application
# 将当前目录（dockerfile所在目录）下所有文件都拷贝到工作目录下（.dockerignore中文件除外）
COPY . .

RUN gradle clean jar

# 采用抖音云基础镜像, 包含https证书, bash, tzdata等常用命令
FROM public-cn-beijing.cr.volces.com/public/dycloud-openjdk:8-jdk-slim
WORKDIR /opt/application

# 分析打包文件, maven: pom.xml 可得
COPY --from=builder /opt/application/build/libs /opt/application

# 写入run.sh
RUN echo -e '#!/usr/bin/env bash\ncd /opt/application/ && java -jar $(ls | grep .jar -m 1) ' > /opt/application/run.sh

# 指定run.sh权限
Run chmod a+x run.sh

EXPOSE 8000

#CMD ["sh", "run.sh"]

